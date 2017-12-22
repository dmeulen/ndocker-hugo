#!/usr/bin/env sh

/usr/bin/hugo server --theme=${HUGO_THEME} --baseURL="${HUGO_BASE_URL}" --appendPort=false -s "/local/www/" --bind=0.0.0.0
