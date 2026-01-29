#!/bin/bash

# Builds a repository of scrapers for Stash package system
# Outputs to _site with:
#   index.yml - package index
#   <scraper_id>.zip - individual scraper packages

outdir="$1"
if [ -z "$outdir" ]; then
    outdir="_site"
fi

rm -rf "$outdir"
mkdir -p "$outdir"

# Make outdir absolute
outdir=$(cd "$outdir" && pwd)

buildScraper()
{
    f=$1
    dir=$(dirname "$f")

    # get the scraper id from the filename
    scraper_id=$(basename "$f" .yml)

    echo "Processing $scraper_id"

    # get version info from git
    version=$(git log -n 1 --pretty=format:%h -- "$f")
    updated=$(TZ=UTC0 git log -n 1 --date="format-local:%F %T" --pretty=format:%ad -- "$f")

    # create the zip file
    zipfile="$outdir/$scraper_id.zip"

    # extract name from yml file
    name=$(grep "^name:" "$f" | cut -d'"' -f2)
    if [ -z "$name" ]; then
        name=$(grep "^name:" "$f" | cut -d':' -f2- | sed 's/^ *//')
    fi

    # create zip
    pushd "$dir" > /dev/null
    zip "$zipfile" "$scraper_id.yml" > /dev/null
    popd > /dev/null

    # write to index
    echo "- id: $scraper_id
  name: $name
  version: $version
  date: $updated
  path: $scraper_id.zip
  sha256: $(shasum -a 256 "$zipfile" | cut -d' ' -f1)
" >> "$outdir"/index.yml
}

# find all yml files in ./scrapers
for f in ./scrapers/*.yml; do
    buildScraper "$f"
done
