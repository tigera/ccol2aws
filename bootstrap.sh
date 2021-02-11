#! /bin/sh

echo If difficulty is encountered, please let us know in the academy channel on Calico Users slack.

[[ "${AWS_EXECUTION_ENV}" != "CloudShell" ]] && echo Please use AWS CloudShell. && exit 1

[[ ! -d "~/.local/bin" ]] && mkdir -p ~/.local/bin

echo Downloading lab assets.

calicoctl -h > /dev/null || (echo Downloading calicoctl && curl -Lo ~/.local/bin/calicoctl https://github.com/projectcalico/calicoctl/releases/download/v3.17.1/calicoctl-linux-amd64 )
kubectl -h > /dev/null || (echo Downloading Kubectl && curl -Lo ~/.local/bin/kubectl https://dl.k8s.io/release/v1.19.0/bin/linux/amd64/kubectl )
kops -h > /dev/null || (echo Downloading kOps && curl -Lo ~/.local/bin/kops https://github.com/kubernetes/kops/releases/download/v1.19.0/kops-linux-amd64 )
verify >/dev/null || (echo Downloading Verify && curl -Lo ~/.local/bin/verify https://github.com/tigera/ccol1/releases/download/1.0/verify )
eksctl -h > /dev/null || (echo Downloading eksctl && curl -Lo /tmp/eksctl.tgz https://github.com/weaveworks/eksctl/releases/download/0.37.0/eksctl_Linux_amd64.tar.gz && tar xzvf /tmp/eksctl.tgz > /dev/null && mv eksctl ~/.local/bin/eksctl )
chmod +x ~/.local/bin/*

echo Verifying installation.
calicoctl -h > /dev/null || (echo Error downloading calicoctl. Please try again. && rm -f "~/.local/bin/calicoctl" && exit 1)
kubectl -h > /dev/null || (echo Error downloading kubectl. Please try again. && rm -f "~/.local/bin/kubectl" && exit 1)
kops -h > /dev/null || (echo Error downloading kops. Please try again. && rm -f "~/.local/bin/kops" && exit 1)
verify > /dev/null || (echo Error downloading verify. Please try again. && rm -f "~/.local/bin/verify" && exit 1)
eksctl -h > /dev/null || (echo Error downloading eksctl. Please try again. && rm -f "~/.local/bin/eksctl" && exit 1)
echo Installation complete.
exit 0

