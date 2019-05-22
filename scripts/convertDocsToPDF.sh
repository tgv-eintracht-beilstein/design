#!/bin/bash
INPUT_FOLDER=$1
SECRET=$2

####

OUTPUT_FOLDER=dist
FILETYPE=docx
CONVERTAPI=https://v2.convertapi.com/convert/docx/to/pdf\?Secret\=${SECRET}\&download\=attachment
FILES=${INPUT_FOLDER}/*.${FILETYPE}

mkdir -p $OUTPUT_FOLDER

for filename in $FILES; do
  output=${filename/\.$FILETYPE/}
  output=${output/$@/$OUTPUT_FOLDER}.pdf

  curl \
  -s \
  -F "PageSize=a4" \
  -F "PdfAuthor=TGV Eintracht Beilstein 1823 e.V." \
  -F "File=@./${filename}" \
  ${CONVERTAPI} \
  > $output
done