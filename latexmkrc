$pdflatex = 'lualatex --interaction=nonstopmode --file-line-error';
$biber = 'biber --input-directory=bibtex-refs/';
$silent = 1;
$bibtex_use = 2;
$pdf_mode = 1;
$out_dir = 'build';
@default_files = ('cv.tex');

END {
  if($cleanup_mode == 0) {
    system("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dDownsampleColorImages=true -dColorImageResolution=300 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=\"${out_dir}/cv-compressed.pdf\" \"${out_dir}/cv.pdf\"");
  } elsif($cleanup_mode == 1 && -e "${out_dir}/main-compressed.pdf") {
    unlink("${out_dir}/main-compressed.pdf");
  }
}
