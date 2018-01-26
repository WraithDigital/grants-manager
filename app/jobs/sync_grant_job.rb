class SyncGrantJob < Que::Job

  @priority = 20

  def run(id)
    grant = Grant.find(id)
    build_request(grant).run
  end

  def build_request(grant)
    request = Typhoeus::Request.new(
      'http://b39e75e9.ngrok.io/api',
      method: :post,
      headers: {
        'Authorization': Settings.gtc.api_key,
        'Content-Type': 'application/json'
      },
      body: {
        remote_id:         grant.remote_id,
        title:             grant.title,
        url:               grant.url,
        agency:            grant.agency,
        time_zone:         grant.time_zone,
        sponsor:           grant.sponsor,
        amount:            grant.amount,
        activity_location: grant.activity_location,
        applicant_type:    grant.applicant_types.pluck(:name),
        residency:         grant.residency,
        deadline:          format_deadlines(grant),
        rendered_body:     CustomMarkdown.new.render(grant.body)
      }.to_json
    )

    request.on_complete do |response|
      if response.success?
        begin
          json = JSON.parse(response.body)
          remote_id = json['remote_id']

          grant.update_columns(dirty: false, remote_id: remote_id)
        rescue => e
          raise "GRANT FAILED TO SYNC - ID: #{grant.id}, REMOTE_ID: #{remote_id}, EXCEPTION: #{e}"
        end
      elsif response.timed_out? || response.code == 0
        # timeout or some unknown error
        raise "GRANT JOB TIMED OUT - ID: #{grant.id}"
      else
        # server error
        raise "GRANT JOB SERVER ERROR - ID: #{grant.id}, RESPONSE: #{response.body}"
      end
    end

    request
  end

  private

  def format_deadlines(grant)
    deadlines = []
    grant.deadlines.each do |deadline|
      dl = {
        date:     deadline.date,
        item_due: deadline.item_due,
        notes:    deadline.notes
      }
      deadlines << dl
    end
    deadlines
  end

end
