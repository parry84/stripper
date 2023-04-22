# Stripper

PDF metadata may contain sensitive information like authors' names and details on the information system and architecture. All this information can be exploited easily by attackers to footprint and later attack an organization. This tool sanitizes PDFs that are intended for public sharing.

## Usage

The input and output files can be piped through the standard input and standard output:

```sh
cat ./my_file.pdf | ./stripper.sh > ./my_file.cleaned.pdf
```

alternatively, they can be specified using the `--input` (`-i`) and `--output` (`-o`) options:

```sh
./stripper.sh --input ./my_file.pdf --output ./my_file.cleaned.pdf
```

To process a batch of PDFs, a folder can be given to the `--dir` (`-d`) option. The tool with scan for PDFs only in the first level and will generate the sanitized ones into a new folder with the same name plus the `.stripped` suffix.

```sh
./stripper --dir ./my_pdfs/
```
