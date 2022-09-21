docker build -t dannycanuto/multi-client:latest -t dannycanuto/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dannycanuto/multi-server:latest -t dannycanuto/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dannycanuto/multi-worker:latest -t dannycanuto/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dannycanuto/multi-client:latest
docker push dannycanuto/multi-server:latest
docker push dannycanuto/multi-worker:latest

docker push dannycanuto/multi-client:$SHA
docker push dannycanuto/multi-server:$SHA
docker push dannycanuto/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dannycanuto/multi-server:$SHA
kubectl set image deployments/client-deployment client=dannycanuto/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dannycanuto/multi-worker:$SHA