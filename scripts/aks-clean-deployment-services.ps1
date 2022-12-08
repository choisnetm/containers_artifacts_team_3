./az-login.ps1

kubectl delete deployment poi-deployment
kubectl delete deployment trips-deployment
kubectl delete deployment user-java-deployment
kubectl delete deployment users-profiles-deployment
kubectl delete deployment tripviewer-deployment

kubectl delete svc poi
kubectl delete svc trips
kubectl delete svc user-java
kubectl delete svc users-profiles
kubectl delete svc tripviewer