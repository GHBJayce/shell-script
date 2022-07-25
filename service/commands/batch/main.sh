
for service in ${services[@]}; do
    rerun jayce-public/service:$service --action $ACTION
done