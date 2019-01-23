var verbosity = document.querySelector('meta[name="pdfjs_viewer_verbosity"]').content;
PDFJS.verbosity = PDFJS.VERBOSITY_LEVELS[verbosity];
PDFJS.externalLinkTarget = PDFJS.LinkTarget.BLANK;
