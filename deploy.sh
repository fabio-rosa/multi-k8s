docker build -t fabiopt/multi-client:latest -t fabiopt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fabiopt/multi-server:latest -t fabiopt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fabiopt/multi-worker:latest -t fabiopt/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fabiopt/multi-client:latest
docker push fabiopt/multi-client:$SHA

docker push fabiopt/multi-server:latest
docker push fabiopt/multi-server:$SHA

docker push fabiopt/multi-worker:latest
docker push fabiopt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fabiopt/multi-server:$SHA
kubectl set image deployments/client-deployment client=fabiopt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fabiopt/multi-worker:$SHA
