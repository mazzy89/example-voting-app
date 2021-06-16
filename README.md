Example Voting App
=========

A simple distributed application running across multiple Docker containers.

Getting started
---------------

Download [Terraform](https://www.terraform.io/) and [Helm](https://github.com/helm/helm) v3.

Walkthrough
-----------

In regards of the assigment, DigitalOcean has been chosen as cloud provider for its simplicity and fast deployment. It will provide primitives such as compute, network and storage required to run the service components.

Components
----------

* [Traefik](https://traefik.io/) reverse proxy
* [Kube-Prometheus](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)

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
* DigitalOcean does not provide any Disaster Recovery tooling out of the box. For such this reason it is necessary to provide a backup/recovery solution. (i.e. run a `CronJob` that would execute on a time base schedule a backup of the database and save the result in a blob storage like AWS S3 or similar)

Caveats
-------
