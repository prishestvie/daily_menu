<#
.SYNOPSIS
    Submit URLs to IndexNow (Yandex, Bing, Seznam, Naver) for instant indexing.
.DESCRIPTION
    This script submits URLs to the IndexNow API. It can submit individual URLs
    or the entire sitemap. Supports Yandex, Bing, and the global IndexNow endpoint.
.PARAMETER Url
    Single URL to submit (optional). If not specified, submits the sitemap.
.PARAMETER Endpoint
    IndexNow API endpoint. Default: https://yandex.com/indexnow
    Alternatives: https://api.indexnow.org, https://www.bing.com/indexnow
.PARAMETER Key
    IndexNow API key. Default: 4e9e1b79-f56b-4fee-abe7-a3ac4403a01a
.PARAMETER KeyLocation
    Full URL to the key file. Default: https://menunaden.ru/4e9e1b79-f56b-4fee-abe7-a3ac4403a01a.txt
.EXAMPLE
    .\submit-indexnow.ps1 -Url "https://menunaden.ru/"
    Submit a single URL to Yandex IndexNow.
.EXAMPLE
    .\submit-indexnow.ps1 -Url "https://menunaden.ru/" -Endpoint "https://api.indexnow.org"
    Submit a single URL to the global IndexNow endpoint.
.EXAMPLE
    .\submit-indexnow.ps1
    Submit the entire sitemap to Yandex IndexNow.
#>

param(
    [string]$Url = "",
    [string]$Endpoint = "https://yandex.com/indexnow",
    [string]$Key = "4e9e1b79-f56b-4fee-abe7-a3ac4403a01a",
    [string]$KeyLocation = "https://menunaden.ru/4e9e1b79-f56b-4fee-abe7-a3ac4403a01a.txt"
)

# --- Configuration ---
$SiteUrl = "https://menunaden.ru"
$SitemapUrl = "$SiteUrl/sitemap.xml"

# --- Helper: Submit a single URL ---
function Submit-IndexNowUrl {
    param([string]$TargetUrl)

    $body = @{
        host = $SiteUrl
        key = $Key
        keyLocation = $KeyLocation
        urlList = @($TargetUrl)
    } | ConvertTo-Json

    Write-Host "Submitting URL: $TargetUrl" -ForegroundColor Cyan
    Write-Host "Endpoint: $Endpoint" -ForegroundColor Gray
    Write-Host "Body: $body" -ForegroundColor Gray

    try {
        $response = Invoke-RestMethod -Uri $Endpoint -Method Post -Body $body -ContentType "application/json" -ErrorAction Stop
        Write-Host "SUCCESS: URL submitted successfully!" -ForegroundColor Green
        return $true
    }
    catch {
        $statusCode = $_.Exception.Response.StatusCode.value__
        if ($statusCode -eq 200) {
            Write-Host "SUCCESS: URL submitted successfully (HTTP 200)!" -ForegroundColor Green
            return $true
        }
        Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $errorBody = $reader.ReadToEnd()
            Write-Host "Response: $errorBody" -ForegroundColor Red
        }
        return $false
    }
}

# --- Helper: Submit multiple URLs (batch) ---
function Submit-IndexNowBatch {
    param([string[]]$UrlList)

    $body = @{
        host = $SiteUrl
        key = $Key
        keyLocation = $KeyLocation
        urlList = $UrlList
    } | ConvertTo-Json

    Write-Host "Submitting $($UrlList.Count) URLs in batch..." -ForegroundColor Cyan
    Write-Host "Endpoint: $Endpoint" -ForegroundColor Gray

    try {
        $response = Invoke-RestMethod -Uri $Endpoint -Method Post -Body $body -ContentType "application/json" -ErrorAction Stop
        Write-Host "SUCCESS: All URLs submitted successfully!" -ForegroundColor Green
        return $true
    }
    catch {
        $statusCode = $_.Exception.Response.StatusCode.value__
        if ($statusCode -eq 200) {
            Write-Host "SUCCESS: All URLs submitted successfully (HTTP 200)!" -ForegroundColor Green
            return $true
        }
        Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $errorBody = $reader.ReadToEnd()
            Write-Host "Response: $errorBody" -ForegroundColor Red
        }
        return $false
    }
}

# --- Helper: Parse sitemap and extract all URLs ---
function Get-SitemapUrls {
    Write-Host "Fetching sitemap: $SitemapUrl" -ForegroundColor Cyan
    try {
        $sitemapXml = [xml](Invoke-WebRequest -Uri $SitemapUrl -ErrorAction Stop).Content
        $urls = $sitemapXml.urlset.url | ForEach-Object { $_.loc }
        Write-Host "Found $($urls.Count) URLs in sitemap" -ForegroundColor Green
        return $urls
    }
    catch {
        Write-Host "ERROR: Failed to fetch sitemap: $($_.Exception.Message)" -ForegroundColor Red
        return @()
    }
}

# --- Main ---
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "  IndexNow URL Submission Tool" -ForegroundColor Yellow
Write-Host "  Site: $SiteUrl" -ForegroundColor Yellow
Write-Host "  Key: $Key" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""

if ($Url) {
    # Submit a single URL
    Submit-IndexNowUrl -TargetUrl $Url
}
else {
    # Submit all URLs from sitemap
    $allUrls = Get-SitemapUrls
    if ($allUrls.Count -gt 0) {
        # IndexNow accepts up to 10,000 URLs per request
        # Submit in batches if needed
        $batchSize = 10000
        for ($i = 0; $i -lt $allUrls.Count; $i += $batchSize) {
            $batch = $allUrls[$i..([Math]::Min($i + $batchSize - 1, $allUrls.Count - 1))]
            Submit-IndexNowBatch -UrlList $batch
        }
    }
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Green