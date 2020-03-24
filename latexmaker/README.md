# Latexmaker is a tool to build LaTeX documents

Recommended usage
```
docker run --rm -v "$(pwd)":/doc --user $(id -u):$(id -g) hombrenieve/sw_craftmanship-latexmaker
```
The image executes the command: *latexmk -shell-escape -pdf document.tex*