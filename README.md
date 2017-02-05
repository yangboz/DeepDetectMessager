# DeepDetectMessager
iMessager for DeepDetect demostration.

![Screenshot of master view](https://github.com/yangboz/DeepDetectMessager/blob/master/ChatBotJSQMessager/screenshots/master.jpeg)
![Screenshot of detail view](https://github.com/yangboz/DeepDetectMessager/blob/master/ChatBotJSQMessager/screenshots/detail.jpeg)

#DeepDetect Server

1.caffe:https://github.com/BVLC/caffe/wiki/Ubuntu-16.04-or-15.10-Installation-Guide

2.curlpp:https://github.com/beniz/deepdetect/issues/126

3.deepdetect:https://deepdetect.com/overview/installing/

##ImageNet Classification Service

1.pull and run docker

`
docker run -d -p 8080:8080 beniz/deepdetect_cpu
`

1.1 build and run

`
nohup ./main/dede -host 118.190.3.169
`

2.create ImageNet/ggnet service

`
curl -X PUT "http://118.190.3.169:8080/services/imageserv" -d '{"mllib":"caffe", "description":"image classification service", "type":"supervised", "parameters":{"input":{"connector":"image"}, "mllib":{"template":"googlenet", "nclasses":1000 } }, "model":{"templates":"../templates/caffe/", "repository":"/root/models/imgnet"} }'
`

3.test service

`
curl -X POST "http://118.190.3.169:8080/predict" -d "{\"service\":\"imageserv\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"https://deepdetect.com/img/ambulance.jpg\"]}"
`

4.kill docker

`
docker rm -fv 1ca885426d1a
`

##Clothing Classification Service


1.create clothing service

`
curl -X PUT "http://118.190.3.169:8080/services/clothing" -d '{"mllib":"caffe", "description":"clothes classification", "type":"supervised", "parameters":{"input":{"connector":"image", "height":224, "width":224 }, "mllib":{"nclasses":304 } }, "model":{"repository":"/root/models/clothing"} }'
`

2.test service

`
curl -X POST "http://118.190.3.169:8080/predict" -d "{\"service\":\"clothing\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"http://4.bp.blogspot.com/-uwu7SmTbBXI/VD_NNJc4Y-I/AAAAAAAAK1I/rt9de3mWXJo/s1600/faux-fur-coat-winter-2014-big-trend-10.jpg\"]}"
`

##Bags Classification Service


1.create bags service

`
curl -X PUT "http://118.190.3.169:8080/services/bags" -d '{"mllib":"caffe", "description":"bags classification", "type":"supervised", "parameters":{"input":{"connector":"image", "height":224, "width":224 }, "mllib":{"nclasses":37 } }, "model":{"repository":"/root/models/bags"} }'
`

2.test service

`
curl -X POST "http://118.190.3.169:8080/predict" -d "{\"service\":\"bags\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"http://i.ebayimg.com/00/s/ODQ5WDU2Ng==/z/nDMAAOSw7I5TtqWl/$_32.JPG\"]}"
`

##Footwear Classification Service


1.create clothing service

`
curl -X PUT "http://118.190.3.169:8080/services/footwear" -d '{"mllib":"caffe", "description":"footwear classification", "type":"supervised", "parameters":{"input":{"connector":"image", "height":224, "width":224 }, "mllib":{"nclasses":51 } }, "model":{"repository":"/root/models/footwear"} }'
`

2.test service

`
curl -X POST "http://118.190.3.169:8080/predict" -d "{\"service\":\"clothing\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"http://4.bp.blogspot.com/-uwu7SmTbBXI/VD_NNJc4Y-I/AAAAAAAAK1I/rt9de3mWXJo/s1600/faux-fur-coat-winter-2014-big-trend-10.jpg\"]}"
`

##Buildings Classification Service


1.create buildings service

`
curl -X PUT "http://118.190.3.169:8080/services/buildings" -d '{"mllib":"caffe", "description":"buildings classification", "type":"supervised", "parameters":{"input":{"connector":"image", "height":224, "width":224 }, "mllib":{"nclasses":185 } }, "model":{"repository":"/root/models/buildings"} }'
`

2.test service

`
curl -X POST "http://118.190.3.169:8080/predict" -d "{\"service\":\"buildings\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"http://118.190.3.169/images/Temple-of-Heaven.jpg\"]}"
`


##Sports Classification Service


1.create sports service

`
curl -X PUT "http://118.190.3.169:8080/services/sports" -d '{"mllib":"caffe", "description":"sports classification", "type":"supervised", "parameters":{"input":{"connector":"image", "height":224, "width":224 }, "mllib":{"nclasses":143 } }, "model":{"repository":"/root/models/sports"} }'
`

2.test service

`
curl -X POST "http://118.190.3.169:8080/predict" -d "{\"service\":\"sports\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"https://en.wikipedia.org/wiki/Basketball#/media/File:Jordan_by_Lipofsky_16577.jpg\"]}"
`

##Sentiment analysis Service


1.create sentiment service

`
curl -X PUT 'http://118.190.3.169:8080/services/sent_en' -d '{"mllib":"caffe", "description":"English sentiment classification", "type":"supervised", "parameters":{"input":{"connector":"txt", "characters":true, "alphabet":"abcdefghijklmnopqrstuvwxyz0123456789,;.!?'\''", "sequence":140 }, "mllib":{"nclasses":2 } }, "model":{"repository":"/root/models/sent_en_char"} }'
`

2.test service

`
curl -X POST 'http://118.190.3.169:8080/predict' -d '{"service":"sent_en", "parameters":{"mllib":{"gpu":true } }, "data":["Chilling in the West Indies"] }'
`



#References

DeepDetect(LGPL): https://deepdetect.com/

iOS ChatbotMessager: https://github.com/yangboz/ChatBotsMessager

## Support on Beerpay
Hey dude! Help me out for a couple of :beers:!

[![Beerpay](https://beerpay.io/yangboz/DeepDetectMessager/badge.svg?style=beer-square)](https://beerpay.io/yangboz/DeepDetectMessager)  [![Beerpay](https://beerpay.io/yangboz/DeepDetectMessager/make-wish.svg?style=flat-square)](https://beerpay.io/yangboz/DeepDetectMessager?focus=wish)
