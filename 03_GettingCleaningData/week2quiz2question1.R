library(httr)
library(httpuv)
library(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
#    oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    My custom key and secret below in order to access other APIs
myapp <- oauth_app("github",
  key = "b4c0c51a56c1775c0886",
  secret = "ca8cec50ef9b152fbd9aa7fc86b4aa7d4fd02845")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp,cache=FALSE)

# 4. Use API
gtoken <- config(token = github_token)
#req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
#stop_for_status(req)
#content(req)

jtleekrepos = GET("https://api.github.com/users/jtleek/repos", gtoken)
json1 = content(jtleekrepos)
json2 = fromJSON(toJSON(json1))
#json2

#names(json2)
#json2$branches_url

# Using Branch to find datasharing
# repo <- json2[json2$branches_url=="https://api.github.com/repos/jtleek/datasharing/branches{/branch}",]
# Using name to find datasharing
repo <- json2[json2$name=="datasharing",]
createdtime <- repo["created_at"]
createdtime