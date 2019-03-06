# Optune Servo with Kubernetes (adjust) and NewRelic (measure) drivers

## Build servo container
```
docker build . -t example.com/servo-k8s-newrelic
```

Note: this version has support for `jvm` encoder and uses the `java_args_encoder` branch of the k8s adjust driver
