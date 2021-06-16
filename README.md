Example Voting App
=========

A simple distributed application running across multiple Docker containers.

Getting started
---------------

Download [Terraform](https://www.terraform.io/) and [Helm](https://github.com/helm/helm) v3.

Walkthrough
-----------

In regards of the assigment, DigitalOcean has been chosen as cloud provider for its simplicity and fast deployment. It will provide primitives for compute, network and storage required to run the service components.

Components
----------

* [Traefik](https://traefik.io/) reverse proxy
* [Kube-Prometheus](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
* [PostgreSQL on DigitalOcean](https://docs.digitalocean.com/products/databases/postgresql/)

Install
-------

Run:

```sh
cd terraform
export TF_VAR_do_token=...
terraform init
terraform plan
terraform apply
```

The above commands will deploy automatically the entire service components on a Kubernetes cluster on the FRA1 region.

Note that it is required to have a DigitalOcean token in order to run Terraform successfully.

Architecture
-----

![Architecture diagram](architecture.png)

* A front-end web app in [Python](/vote) or [ASP.NET Core](/vote/dotnet) which lets you vote between two options
* A [Redis](https://hub.docker.com/_/redis/) or [NATS](https://hub.docker.com/_/nats/) queue which collects new votes
* A [.NET Core](/worker/src/Worker), [Java](/worker/src/main) or [.NET Core 2.1](/worker/dotnet) worker which consumes votes and stores them in…
* A [Postgres](https://hub.docker.com/_/postgres/) database cluster managed by DigitalOcean.
* A [Node.js](/result) or [ASP.NET Core SignalR](/result/dotnet) webapp which shows the results of the voting in real time.

Notes
-----

* The voting application only accepts one vote per client. It does not register votes if a vote has already been submitted from a client.
* DigitalOcean provides automatic daily backups for the managed PostgreSQL out of the box.
* SSL Certiicates are created and managed by a CloudFlare account.

Caveats
-------
