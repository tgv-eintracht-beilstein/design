#!/bin/bash
INPUT_FOLDER=$1
SECRET=$2

####

OUTPUT_FOLDER=dist
FILETYPE=docx
CONVERTAPI=https://v2.convertapi.com/convert/docx/to/pdf\?Secret\=${SECRET}\&download\=attachment
FILES=${INPUT_FOLDER}/*.${FILETYPE}

mkdir -p $OUTPUT_FOLDER

echo Folder dist before
ls dist

for input in $FILES; do
  output=${input/\.$FILETYPE/}
  output=${output/$INPUT_FOLDER/$OUTPUT_FOLDER}
  output=$output.pdf

  echo Converting $input to $output

  curl \
  -s \
  -F "PageSize=a4" \
  -F "PdfAuthor=TGV Eintracht Beilstein 1823 e.V." \
  -F "File=@./${input}" \
  ${CONVERTAPI} \
  > $output
done

echo Folder dist before
ls dist