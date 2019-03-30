#!/usr/bin/env bash

if [ $# -ne 2 ]; then
    echo 'Usage: markdown input output'
    exit 1
fi

input="$1"
output="$2"

cat << EOF > "$output"
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/mnt/data/U/Universita/Markdown/github.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/katex.min.css" integrity="sha384-dbVIfZGuN1Yq7/1Ocstc1lUEm+AT+/rCkibIcC/OmWo5f0EA48Vf8CytHzGrSwbQ" crossorigin="anonymous">
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/katex.min.js" integrity="sha384-2BKqo+exmr9su6dir+qCw08N2ZKRucY4PrGQPPWU1A7FtlCGjmEGFqXCv5nyM5Ij" crossorigin="anonymous"></script>
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/contrib/auto-render.min.js" integrity="sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI" crossorigin="anonymous"
    onload="f()"></script>

<script>
    function f(){renderMathInElement(document.body,{
              delimiters: [
                  {left: '\$$', right: '\$$', display: true},
                  {left: '$', right: '$', display: false},
               ]
            });
    }
</script>
</head>
<body class="markdown-body">
<article class="markdown-body">
EOF

markdown-it "$input" >> "$output"

echo '</article></body></html>' >> "$output"
