Example Voting App
=========

A simple distributed application running across multiple Docker containers.

Getting started
---------------

Download [Terraform](https://www.terraform.io/) and [Helm](https://github.com/helm/helm) version 3.

It is required to have a [DigitalOcean](https://www.digitalocean.com/) account and a CloudFlare account with an existing managed domain.

Walkthrough
-----------

In regards of the assigment, DigitalOcean has been chosen as cloud provider for its simplicity and fast deployment. It will provide primitives for compute, network and storage required to run all the service components and meet the specified requirements.

Components
----------

* [Traefik](https://traefik.io/) reverse proxy
* [Kube-Prometheus](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
* [PostgreSQL on DigitalOcean](https://docs.digitalocean.com/products/databases/postgresql/)

Install
-------

Create under `terraform` a file named `terraform.tfvars` that looks like:

```tf
do_token=
cloudflare_api_token=
cloudflare_domain=
cloudflare_zone_id=
```

Run:

```sh
cd terraform
terraform init
terraform plan
terraform apply
```

The above commands will deploy automatically the entire service components on a Kubernetes cluster on the Frankurt (FRA1) region.

Note that it is required to have a DigitalOcean token in order to apply Terraform successfully and a CloudFlare token to create automatically DNS entries of the `Ingress` objects.

Architecture
-----

![Architecture diagram](architecture.png)

* A front-end web app in [Python](/vote) or [ASP.NET Core](/vote/dotnet) which lets you vote between two options
* A [Redis](https://hub.docker.com/_/redis/) or [NATS](https://hub.docker.com/_/nats/) queue which collects new votes
* A [.NET Core](/worker/src/Worker), [Java](/worker/src/main) or [.NET Core 2.1](/worker/dotnet) worker which consumes votes and stores them in…
* A [Postgres](https://hub.docker.com/_/postgres/) database cluster managed by DigitalOcean.
* A [Node.js](/result) or [ASP.NET Core SignalR](/result/dotnet) webapp which shows the results of the voting in real time.

Observability
-------------

The cloud provider provides out-of-the-box monitoring UIs to observe how the droplets (VMs) perform. 

Prometheus stack is deployed in the Kubernetes cluster [node-exporter](https://github.com/prometheus/node_exporter) collect metrics on the cluster nodes.

SSL/TLS
-------

SSL connection is handled in the CloudFlare account using the [Full mode](https://support.cloudflare.com/hc/en-us/articles/200170416-End-to-end-HTTPS-with-Cloudflare-Part-3-SSL-options#:~:text=origin%20web%20server.-,Full,at%20the%20origin%20web%20server.). Without any requirements provided for the take home assisgment in handling SSL certicates, this seems the faster and better way to handle in such context SSL certificates. The provider manages SSL certificates lifecycle so operations friction is reduced at minimium.

Notes
-----

* The voting application only accepts one vote per client. It does not register votes if a vote has already been submitted from a client.
* DigitalOcean provides automatic daily backups for the managed PostgreSQL out of the box.

Caveats
-------
