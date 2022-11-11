docker build -t garzeah/multi-client:latest -t garzeah/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t garzeah/multi-server:latest -t garzeah/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t garzeah/multi-worker:latest -t garzeah/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push garzeah/multi-client:latest
docker push garzeah/multi-server:latest
docker push garzeah/multi-worker:latest

docker push garzeah/multi-client:$SHA
docker push garzeah/multi-server:$SHA
docker push garzeah/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=garzeah/multi-server:$SHA
kubectl set image deployments/client-deployment client=garzeah/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=garzeah/multi-worker:$SHA