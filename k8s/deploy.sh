docker build -t chihfenl/multi-client:latest -t chihfenl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chihfenl/multi-server:latest -t chihfenl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chihfenl/multi-worker:latest -t chihfenl/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chihfenl/multi-client:latest
docker push chihfenl/multi-server:latest
docker push chihfenl/multi-worker:latest
docker push chihfenl/multi-client:$SHA
docker push chihfenl/multi-server:$SHA
docker push chihfenl/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chihfenl/multi-server:$SHA
kubectl set image deployments/client-deployment client=chihfenl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chihfenl/multi-worker:$SHA

