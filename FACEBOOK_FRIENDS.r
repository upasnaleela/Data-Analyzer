library("httpuv")
library("Rfacebook")
library("RColorBrewer")
library("rjson")

token <- 'EAACEdEose0cBABNu9nLOe2harEjLEQ6RMiSHkEweEayvkaqsfIBvyDm9IPOo9me18bBpsIqlOKhJWtQNmitqh8cGZCxAWrOaLDAZBUmm3d0ZCA7NI4UwDmE0x3WrxuIHjlBTLuTOrVY7EWV6RgPCujkQjKN1sSWvuWDzbkyuENZCKl5RuBhkUWUUfttkgeRojbsuISybeQZDZD'
options(RCurlOptions=list(verbose=FALSE,capath=system.file("CurlSSL","cacert.pem",package="RCurl"),ssl.verifypeer=FALSE))
ME<-getUsers("me",token=token)
myFriends<-getFriends(token,simplify=FALSE)
table(myFriends)
pie(table(myFriends$relationship_status))

