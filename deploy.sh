docker build -t sarvang00/fibocalc-client:latest -t sarvang00/fibocalc-client:$SHA -f ./client/Dockerfile ./client
docker build -t sarvang00/fibocalc-server:latest -t sarvang00/fibocalc-server:$SHA -f ./server/Dockerfile ./server
docker build -t sarvang00/fibocalc-worker:latest -t sarvang00/fibocalc-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sarvang00/fibocalc-client:latest
docker push sarvang00/fibocalc-server:latest
docker push sarvang00/fibocalc-worker:latest

docker push sarvang00/fibocalc-client:$SHA
docker push sarvang00/fibocalc-server:$SHA
docker push sarvang00/fibocalc-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sarvang00/fibocalc-server:$SHA
kubectl set image deployments/client-deployment client=sarvang00/fibocalc-client:$SHA
kubectl set image deployments/worker-deployment worker=sarvang00/fibocalc-worker:$SHA