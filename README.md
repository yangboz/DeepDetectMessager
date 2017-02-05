# DeepDetectMessager
iMessager for DeepDetect demostration.

![Screenshot of master view](https://github.com/yangboz/DeepDetectMessager/blob/master/ChatBotJSQMessager/screenshots/master.jpeg)
![Screenshot of detail view](https://github.com/yangboz/DeepDetectMessager/blob/master/ChatBotJSQMessager/screenshots/detail.jpeg)

#DeepDetect Server

1.caffe:https://github.com/BVLC/caffe/wiki/Ubuntu-16.04-or-15.10-Installation-Guide

2.curlpp:https://github.com/beniz/deepdetect/issues/126

3.deepdetect:https://deepdetect.com/overview/installing/

##ImageNet Classification

1.pull and run docker

`
docker run -d -p 8080:8080 beniz/deepdetect_cpu
`

2.create ggnet service

`
curl -X PUT "http://localhost:8080/services/imageserv" -d "{\"mllib\":\"caffe\",\"description\":\"image classification service\",\"type\":\"supervised\",\"parameters\":{\"input\":{\"connector\":\"image\"},\"mllib\":{\"nclasses\":1000}},\"model\":{\"repository\":\"/opt/models/ggnet/\"}}"
`

3.test service

`
curl -X POST "http://localhost:8080/predict" -d "{\"service\":\"imageserv\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"https://deepdetect.com/img/ambulance.jpg\"]}"
`
4.kill docker
`
docker rm -fv 1ca885426d1a
`

##Clothing Classification


1.create clothing service

`
curl -X PUT "http://localhost:8080/services/clothing" -d '{"mllib":"caffe", "description":"clothes classification", "type":"supervised", "parameters":{"input":{"connector":"image", "height":224, "width":224 }, "mllib":{"nclasses":304 } }, "model":{"repository":"/data/models/clothing"} }'
`

2.test service

`
curl -X POST "http://localhost:8080/predict" -d "{\"service\":\"clothing\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"http://4.bp.blogspot.com/-uwu7SmTbBXI/VD_NNJc4Y-I/AAAAAAAAK1I/rt9de3mWXJo/s1600/faux-fur-coat-winter-2014-big-trend-10.jpg\"]}"
`

##Bags Classification


1.create bags service

`
curl -X PUT "http://localhost:8080/services/bags" -d '{"mllib":"caffe", "description":"bags classification", "type":"supervised", "parameters":{"input":{"connector":"image", "height":224, "width":224 }, "mllib":{"nclasses":304 } }, "model":{"repository":"/data/models/bags"} }'
`

2.test service

`
curl -X POST "http://localhost:8080/predict" -d "{\"service\":\"bags\",\"parameters\":{\"input\":{\"width\":224,\"height\":224},\"output\":{\"best\":3},\"mllib\":{\"gpu\":false}},\"data\":[\"http://i.ebayimg.com/00/s/ODQ5WDU2Ng==/z/nDMAAOSw7I5TtqWl/$_32.JPG\"]}"
`

##Sentiment analysis


1.create sentiment service

`
curl -X PUT 'http://localhost:8080/services/sent_en' -d '{"mllib":"caffe", "description":"English sentiment classification", "type":"supervised", "parameters":{"input":{"connector":"txt", "characters":true, "alphabet":"abcdefghijklmnopqrstuvwxyz0123456789,;.!?'\''", "sequence":140 }, "mllib":{"nclasses":2 } }, "model":{"repository":"/data/sent_en_char"} }'
`

2.test service

`
curl -X POST 'http://localhost:8080/predict' -d '{"service":"sent_en", "parameters":{"mllib":{"gpu":true } }, "data":["Chilling in the West Indies"] }'
`



#References

DeepDetect(LGPL): https://deepdetect.com/

iOS ChatbotMessager: https://github.com/yangboz/ChatBotsMessager

## Support on Beerpay
Hey dude! Help me out for a couple of :beers:!

[![Beerpay](https://beerpay.io/yangboz/DeepDetectMessager/badge.svg?style=beer-square)](https://beerpay.io/yangboz/DeepDetectMessager)  [![Beerpay](https://beerpay.io/yangboz/DeepDetectMessager/make-wish.svg?style=flat-square)](https://beerpay.io/yangboz/DeepDetectMessager?focus=wish)