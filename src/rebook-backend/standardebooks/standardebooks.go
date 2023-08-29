package main

import (
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"github.com/cavaliergopher/grab/v3"
	"github.com/gocolly/colly"
	"os"
	"regexp"
	"text/template"
)

type Book struct {
	Url    string
	Author string
	Name   string
}

type Query struct {
	Query string
}
type BookUrl struct {
	Path string
}

func search(url string, query string) {
	books := []Book{}
	c := colly.NewCollector()
	c.OnHTML("ol li", func(e *colly.HTMLElement) {
		temp := Book{}
		temp.Url = "https://standardebooks.org" + e.ChildAttr("p:nth-child(2) a", "href")
		temp.Name = e.ChildText("p:nth-child(2) a span")
		temp.Author = e.ChildText("p.author a span")

		if temp.Url != "" && temp.Name != "" && temp.Author != "" {
			books = append(books, temp)
		}
	})

	q := Query{query}
	tmpl, err := template.New("test").Parse(url)
	if err != nil {
		panic(err)
	}

	buf := &bytes.Buffer{}
	err = tmpl.Execute(buf, q)
	if err != nil {
		panic(err)
	}
	c.Visit(buf.String())

	j, err := json.Marshal(books)
	if err != nil {
		panic(err)
	}
	fmt.Println(string(j))
}

func download(url string, author string, name string, path string) {
	c := colly.NewCollector()
	c.OnHTML("section#download li:first-child a.epub", func(e *colly.HTMLElement) {
		download_url := e.Attr("href")
		resp, err := grab.Get(".", fmt.Sprintf("https://standardebooks.org/%s", download_url))
		if err != nil {
			panic(err)
		}

		regexp, err := regexp.Compile(`[^a-zA-Z\.0-9]`)
		target := regexp.ReplaceAllString(fmt.Sprintf("%s-%s.epub", author, name), "")
		target = fmt.Sprintf("%s/%s", path, target)
		os.Rename(resp.Filename, target)
		fmt.Println("Download saved to", target)
	})

	c.Visit(url)
}

func main() {

	search_url := "https://standardebooks.org/ebooks?query={{ .Query }}&sort=newest&view=grid&per-page=48"

	action := flag.String("action", "", "Action (search/download")
	query := flag.String("query", "", "Search Query")
	author := flag.String("author", "", "Book author")
	name := flag.String("name", "", "Book name")
	url := flag.String("url", "", "Download URL")
	path := flag.String("path", "", "Download Path")

	flag.Parse()

	if *action == "search" {
		search(search_url, *query)
	} else if *action == "download" {
		download(*url, *author, *name, *path)
	}
}
