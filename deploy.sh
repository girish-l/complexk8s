docker build -t girishl/multi-client:latest -t girishl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t girishl/multi-server:latest -t girishl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t girishl/multi-worker:latest -t girishl/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push girishl/multi-client:latest
docker push girishl/multi-server:latest
docker push girishl/multi-worker:latest

docker push girishl/multi-client:$SHA
docker push girishl/multi-server:$SHA
docker push girishl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=girishl/multi-server:$SHA
kubectl set image deployments/client-deployment client=girishl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=girishl/multi-worker:$SHA
