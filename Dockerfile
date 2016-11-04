FROM golang:latest

WORKDIR /

# Add and install etcd-operator
ADD . /go/src/github.com/coreos/etcd-operator
RUN cd /go/src/github.com/coreos/etcd-operator && curl https://glide.sh/get | sh && glide install && go build -ldflags "-X github.com/coreos/etcd-operator/pkg/util/k8sutil.BackupImage=quay.io/barakmich/etcd-operator-free" -o etcd-operator ./cmd/operator/main.go && go build -ldflags "-X github.com/coreos/etcd-operator/pkg/util/k8sutil.BackupImage=quay.io/barakmich/etcd-operator-free" -o etcd-backup ./cmd/backup/main.go && mv etcd-backup /usr/local/bin && mv etcd-operator /usr/local/bin && cd / && rm -rf /go

CMD ["/bin/sh", "-c", "/usr/local/bin/etcd-operator"]

