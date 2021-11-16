.ONESHELL:
SHELL := /bin/bash
SRC = $(wildcard ./*.ipynb)

all: netdata-airflow-utils docs

netdata-airflow-utils: $(SRC)
	nbdev_build_lib
	touch netdata-pandas-utils

sync:
	nbdev_update_lib

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

bump:
	nbdev_bump_version

release: pypi
	nbdev_bump_version

conda_release:
	fastrelease_conda_package

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist