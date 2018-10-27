# UCP Client

This is a simple helper container to connect to a remote Docker Enterprise UCP (Universal Control Plane) via a Docker container which contains both a Docker client and a Kubernetes Client (`kubectl`).

## Build

- Pull the repository with the `git clone git@github.com:MaximeHeckel/ucp-client.git`
- cd in the repository and run `docker build -t NAMESPACE/ucp-client .`

## Run

For use this container you need a working UCP.
Run the following command:
`docker run -d --rm -e UCP_USER="your user name" -e UCP_HOST="your.ucp.host" -e UCP_SESSION_TOKEN="your session token" --name ucp-client maximeheckel/ucp-client:latest`

This will download the client bundle from your UCP host and set up your environment. This container runs in the background.

You can then exec inside the container via:

`docker exec -it ucp-client sh -c "source ./env.sh && /bin/sh"`

You now have a shell where you can run docker and kubernetes commands against your UCP instance.