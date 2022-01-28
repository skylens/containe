# gost

## gost

```bash
git clone https://github.com/ginuerzh/gost.git /tmp/gost
cd /tmp/gost
env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags "-s -w -X main.VERSION=$(git tag | tail -1)" -o ./gost ./cmd/gost
```

## gost-plugin

!!! 编译有问题

```bash
git clone https://github.com/maskedeken/gost-plugin.git /tmp/gost-plugin
cd /tmp/gost-plugin
env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 go build -trimpath -ldflags "-s -w -X main.VERSION=$(git tag | tail -1)" -o ./gost-plugin
```