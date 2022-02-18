$docsRepos = Get-Content .\MicrosoftDocsRepos.txt

$audienceCollection = @()
$topicCollection = @()
$serviceCollection = @()
$taxonomyCollection = @()
    
foreach ($repo in $docsRepos) {

    if ($repo.EndsWith("-pr")) {
        continue
    }

    $repoUrl = "https://github.com/MicrosoftDocs/$($repo).git"

    git clone $repoUrl

    $docItems = Get-ChildItem ".\$repo\" -Recurse -Filter "*.md"

    foreach ($docItem in $docItems) {  

        # Implement a status bar

        $docItemContent = Get-Content $docItem.FullName

        if ($null -eq $docItemContent) {
            continue
        }

        $contentIndex = $docItemContent.LastIndexOf("---")

        $yamlEnd = 0
        for ($i = 1; $i -lt $contentIndex.Count; $i++) {
            if ($contentIndex[$i] -eq 0) {
                $yamlEnd = $i
                break
            }
        }        

        $yamlContent = $docItemContent | Select-Object -First ($yamlEnd + 1)

        if ($null -eq $yamlContent) {
            continue
        }
        
        $yaml = $null
        try {
            $yaml = $yamlContent | ConvertFrom-Yaml
            if ($null -ne $yaml) {
                if ($yaml.ContainsKey("ms.audience")) {
                    $audienceCollection += $yaml.'ms.audience'
        
                }
                if ($yaml.ContainsKey("ms.topic")) {
                    $topicCollection += $yaml.'ms.topic'
        
                }
                if ($yaml.ContainsKey("ms.service")) {
                    $serviceCollection += $yaml.'ms.service'
        
                }
                if ($yaml.ContainsKey("ms.collection")) {
                    $taxonomyCollection += $yaml.'ms.collection'
                }
            }
                
        }
        catch {
            
        }

    }
    remove-item .\$repo -force -Confirm:$false -Recurse

}
    
Write-Host "Audiences"
$audienceCollection | % { $_.Trim().tolower() } | sort | Get-Unique > audiences.txt
Write-Host "Topics"
$topicCollection | % { $_.Trim().tolower() } | sort | Get-Unique > topic.txt
Write-Host "Services"
$serviceCollection | % { $_.Trim().tolower() } | sort | Get-Unique > service.txt
Write-Host "Taxonomy"
$taxonomyCollection | % { $_.Trim().tolower() } | sort | Get-Unique > collections.txt
