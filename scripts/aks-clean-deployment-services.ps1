az login --username  'hacker5shc@msftopenhack6950ops.onmicrosoft.com' --password '7%XhRhoE3n' --show-only-errors

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