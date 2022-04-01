[![tests](https://github.com/blankse/ddev-pdfreactor/actions/workflows/tests.yml/badge.svg)](https://github.com/blankse/ddev-pdfreactor/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2022.svg)

## What is ddev-pdfreactor?

This repository allows you to quickly install [PDFreactor](https://www.pdfreactor.com/) into a [Ddev](https://ddev.readthedocs.io) project using just `ddev get blankse/ddev-pdfreactor`.

## Installation

1. `ddev get blankse/ddev-pdfreactor`
2. `ddev restart`

## Explanation

This pdfreactor recipe for [ddev](https://ddev.readthedocs.io) installs a [`.ddev/docker-compose.pdfreactor.yaml`](docker-compose.pdfreactor.yaml) using the [`realobjects/pdfreactor`](https://hub.docker.com/r/realobjects/pdfreactor/) docker image.

## Interacting with PDFreactor

* The PDFreactor instance will listen on TCP port 9423 (the PDFreactor default).
* Configure your application to access PDFreactor on the host:port `pdfreactor:9423`.

## License

ddev-pdfreactor is distributed under the [Apache 2.0 license](LICENSE).

**Contributed and maintained by [@blankse](https://github.com/blankse)**
