# Agencies
agency1 = Agency.create!(name: 'Natural Sciences and Engineering Research Council of Canada', shortname: 'NSERC')
agency2 = Agency.create!(name: 'Canadian Institutes of Health Research', shortname: 'CIHR')
agency3 = Agency.create!(name: 'Social Sciences and Humanities Research Council', shortname: 'SSHRC')
agency4 = Agency.create!(name: 'European Community Action Scheme for the Mobility of University Students', shortname: 'ERASMUS')

app_type1 = ApplicantType.create!(name: 'Institution: Test')
app_type2 = ApplicantType.create!(name: 'Non-Profit: Test')
app_type3 = ApplicantType.create!(name: 'Private-Org: Test')


# Admin + regular users
User.create!(
  email: 'admin@example.com',
  password: 'password',
  admin: true
)

user2 = User.create!(
  email: 'user@example.com',
  password: 'password'
)

user3 = User.create!(
  email: 'user2@example.com',
  password: 'password'
)

# user2.grants.create!(
#   agency_id: agency1.id,
#   title: 'Markdown Example',
#   url: 'https://www.example.com/0',
#   time_zone: 'Alaska',
#   body: "# Biggest Title
#
# ## Bigger Title
#
# ### Big Title
#
# #### Smaller Title
#
# Markdown is really cool! This is how you do *bold* and also _italics_!
#
# You can also make [links](http://example.com), and even quotes:
#
# > This is a block quote of something someone said. Pretty nifty
# >
# > This is how you make a new line in a quote
#
# It allows you to make
#
# - unordered
# - lists
# - of
# - things
#
# ... as well as...
#
# 1. numbered
# 2. lists
# 3. of
# 4. things"
# )
# if Rails.env == 'development'
#   300.times do |t|
#     grant = user2.grants.create!(
#       agency: agency2,
#       title: "Canada Healthcare Research Grant #{t+1}",
#       url: "https://www.example.com/#{t+1}",
#       time_zone: 'Alaska',
#       body: "### This is a grant\n\nthat _allows_ *markdown*!\n\n[I'm a grant link](https://www.researchnet-recherchenet.ca/rnr16/vwOpprtntyDtls.do?prog=2721&view=currentOpps&type=EXACT&resultCount=25&sort=program&next=1&all=1&masterList=true)\n\n[I'm another grant link](https://www.researchnet-recherchenet.ca/rnr16/vwOpprtntyDtls.do?prog=2721&view=currentOpps&type=EXACT&resultCount=25&sort=program&next=1&all=1&masterList=true)"
#     )
#
#     grant.applicant_types << app_type1
#     grant.applicant_types << app_type2
#     grant.applicant_types << app_type3
#
#     t + 1
#   end
# end
# user2.grants.create!(
#   agency: agency2,
#   title: 'Canada Healthcare Research Grant ',
#   url: 'https://www.example.com/2',
#   body: "### This is a grant\n\nthat _allows_ *markdown*!\n\n[I'm a grant link](https://www.researchnet-recherchenet.ca/rnr16/vwOpprtntyDtls.do?prog=2721&view=currentOpps&type=EXACT&resultCount=25&sort=program&next=1&all=1&masterList=true)\n\n[I'm another grant link](https://www.researchnet-recherchenet.ca/rnr16/vwOpprtntyDtls.do?prog=2721&view=currentOpps&type=EXACT&resultCount=25&sort=program&next=1&all=1&masterList=true)"
# )
#
# user2.grants.create!(
#   agency: agency3,
#   title: 'Canada Science Exploration Grant',
#   url: 'https://www.example.com/3',
#   body: "### This is a grant\n\nthat _allows_ *markdown*!\n\n[I'm a grant link](https://www.researchnet-recherchenet.ca/rnr16/vwOpprtntyDtls.do?prog=2721&view=currentOpps&type=EXACT&resultCount=25&sort=program&next=1&all=1&masterList=true)\n\n[I'm another grant link](https://www.researchnet-recherchenet.ca/rnr16/vwOpprtntyDtls.do?prog=2721&view=currentOpps&type=EXACT&resultCount=25&sort=program&next=1&all=1&masterList=true)"
# )
#
# user3.grants.create!(
#   agency: agency1,
#   title: 'Canada HIV Research Grant',
#   url: 'https://www.example.com/4',
#   body: "### This is a grant\n\nthat _allows_ *markdown*!\n\n[I'm a grant link](https://www.researchnet-recherchenet.ca/rnr16/vwOpprtntyDtls.do?prog=2721&view=currentOpps&type=EXACT&resultCount=25&sort=program&next=1&all=1&masterList=true)\n\n[I'm another grant link](https://www.researchnet-recherchenet.ca/rnr16/vwOpprtntyDtls.do?prog=2721&view=currentOpps&type=EXACT&resultCount=25&sort=program&next=1&all=1&masterList=true)"
# )
