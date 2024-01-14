# Fatto a Mano <!-- omit in toc -->

A website for handmade goodies!

## 1. Table of contents

- [1. Table of contents](#1-table-of-contents)
- [2. Development environment setup](#2-development-environment-setup)
  - [2.1. Miniconda](#21-miniconda)
  - [2.2. Environment variables](#22-environment-variables)
    - [2.2.1. General](#221-general)
  - [2.3. Build and run the website](#23-build-and-run-the-website)
- [3. Additional installations before contributing](#3-additional-installations-before-contributing)
  - [3.1. Pre-commit hooks](#31-pre-commit-hooks)
  - [3.2. Commitizen](#32-commitizen)
- [4. Release strategy from `development` to `main` branch](#4-release-strategy-from-development-to-main-branch)

## 2. Development environment setup

The following steps will guide you through the installation procedure.

### 2.1. Miniconda

[<img style="position: relative; bottom: 3px;" src="https://docs.conda.io/en/latest/_images/conda_logo.svg" alt="Conda" width="80"/>](https://docs.conda.io/en/latest/) is required for creating the development environment (it is suggested to install [Miniconda](https://docs.conda.io/en/latest/miniconda.html)).

Use the terminal for navigating to the repository base directory.\
Use the [setup script](#23-setup-the-development-environment-by-using-the-setup-script) to activate the guided installing procedure.
Otherwise use the following command in your terminal to create an environment named `data-lunch` manually.

```
conda env create -f environment.yml
```

Activate the new _Conda_ environment with the following command.

```
conda activate data-lunch
```

### 2.2. Environment variables

The following environment variables are required for running the _web site_, the _makefile_ or _utility scripts_.

#### 2.2.1. General

| Variable | Type  | Description                                     |
| -------- | :---: | ----------------------------------------------- |
| `VOID`   | _str_ | intentionally void, this table is a placeholder |

### 2.3. Build and run the website

Use the makefile to run the website.

Use `make` as shown below.

```
make jekyll-serve
```

## 3. Additional installations before contributing

> This step is not required if the [setup script](#23-setup-the-development-environment-by-using-the-setup-script) is used.

Before contributing please create the `ci-cd` environment.

```
cd requirements
conda env create -f ci-cd.yml
```

### 3.1. Pre-commit hooks

> This step is not required if the [setup script](#23-setup-the-development-environment-by-using-the-setup-script) is used.

Then install the precommit hooks.

```
conda activate pre-commit
pre-commit install
pre-commit autoupdate
```

Optionally run hooks on all files.

```
pre-commit run --all-files
```

### 3.2. Commitizen

> This step is not required if the [setup script](#23-setup-the-development-environment-by-using-the-setup-script) is used.

The _Commitizen_ hook checks that rules for _conventional commits_ are respected in commits messages.
Use the following command to enjoy _Commitizen's_ interactive prompt.

```
conda activate ci-cd
cz commit
```

`cz c` is a shorther alias for `cz commit`.

## 4. Release strategy from `development` to `main` branch

When you are ready to release to the main branch, use the makefile _bump_, _merge_ and _push_.

First bump the version:

```
make commitizen-bump
```

And then _push_ to `remote`:

```
make commitizen-push
```

> The makefile takes care of everything.
>
> If you are curious and you want to know what is done through `make` commands, keep reading.

In order to take advantage of _Commitizen_ `bump` command the following command are executed through `make`.

First checkout on the correct branch.

```
git checkout main
```

Then start the merge process without using the _fast forward_ strategy (`--no-ff`).

```
git merge development --no-ff
```

Now _Commitizen_ `bump` command will add an additional commit with updated versions to every file listed inside `.cz.toml`.

```
cz bump --no-verify
```

Then results of the release process are merged back to the `development` branch.

```
git checkout development
git merge main --no-ff
```
