# Microsoft 365 Keyword Collection

Have you ever looked for a taxonomy for Microsoft 365? Your search is over. 

This repository compiles all the common keywords from Microsoft 365. 

## Keywords and Extractor Script

## Source

The primary source for the keywords are the repositories within the [MicrosoftDocs organization](https://github.com/MicrosoftDocs)  in GitHub. These repositories hold information for nearly all product aspects of Microsoft 365 and are categorized by Microsoft. These categories were extracted and processed accordingly so that  collection can be made available.

### Extractor Script

The extractor script downloads and parses all repositories to gather several keyword lists. The script can be found [here](Create-MicrosoftDocsKeywordCollection.ps1). Running the script requires a few setup steps:

1. Install the YAML PowerShell Module: `Install-Module powershell-yaml`
2. Create a list of MicrosoftDocs repositories you want to extract information from.
3. Run the script.

In regards to 2.: Keep in mind, every repo comes with a lot of data. I used a list of repos within this [file](MicrosoftDocsRepositories.txt). The whole process took around 9 hours to complete and 45 GB of data were downloaded.

## Keywords

There are four types of keywords available: 
- [Audiences](Keywords/Audiences.md): Audiences are groups of interest like Admins, Developers,...
- [Topics](Keywords/Topics.md): hold information about the kind of content, e.g. Article, how-to, end user help,...
- [Services](Keywords/Services.md): A more or less complete list of Microsoft 365 related services
- [Collections](Keywords/Collections.md): Categories used for more detailed description of topics. These are taken-as-is and no further manual processing took place.

## Contribute

Please feel free to contribute to this repo.
