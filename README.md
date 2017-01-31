# DeepDetectMessager
iMessager for DeepDetect demostration.

![Screenshot of master view](https://github.com/yangboz/DeepDetectMessager/blob/master/ChatBotJSQMessager/screenshots/master.jpeg)
![Screenshot of detail view](https://github.com/yangboz/DeepDetectMessager/blob/master/ChatBotJSQMessager/screenshots/detail.jpeg)

#DeepDetect Server

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

#References

DeepDetect(LGPL): https://deepdetect.com/

iOS ChatbotMessager: https://github.com/yangboz/ChatBotsMessager
