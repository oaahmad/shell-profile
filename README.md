# shell-profile

Settings and utilities for my shell profile

<a href="https://github.com/oaahmad/shell-profile/actions" title="Click to see actions">
	<img src="https://github.com/oaahmad/shell-profile/workflows/test/badge.svg" alt="Displays the status of tests">
</a>
<a href="https://github.com/oaahmad/shell-profile/actions" title="Click to see actions">
	<img src="https://github.com/oaahmad/shell-profile/workflows/lint/badge.svg" alt="Displays the status of linters">
</a>
<a href="https://github.com/oaahmad/.github/blob/master/docs/versioning.md" target="_blank" title="Click to see versioning information">
	<img src="https://img.shields.io/badge/versioning-semver-blue" alt="Displays the versioning standard used">
</a>

[About](#about) | [Install](#install) | [Contribute](#contribute)

## About

I use this to sync my shell setup/profile. This includes:
* Settings for my bash profile
* Utility scripts
* Scripts to install software

Run `shell_profile` for help.

## Install

```shell
git clone https://github.com/oaahmad/shell-profile.git
cd shell-profile
make install
```

## Contribute

Read before making issues, or contributing:
* [CONTRIBUTING](https://github.com/oaahmad/.github/blob/master/CONTRIBUTING.md)
* [CODE_OF_CONDUCT](https://github.com/oaahmad/.github/blob/master/CODE_OF_CONDUCT.md)

Read the [style guide](https://github.com/oaahmad/.github/blob/master/docs/style_guide.md) before contributing.

Run `make setup` after cloning. Run `make test` to test your changes. Run `make lint` to check the formatting of your changes. Run `make init` to apply changes to `src/config/`. See [Makefile](Makefile) for more.

If git hooks give you trouble, delete them after running `make setup` (they are in `.git/hooks/`). Just run `make test` and `make lint` before pushing.