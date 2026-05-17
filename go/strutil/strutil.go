package strutil

import (
	"regexp"
	"strings"
)

var nonWord = regexp.MustCompile(`[^\w\s-]`)
var spaces = regexp.MustCompile(`[-\s]+`)

func Slugify(text string) string {
	text = strings.ToLower(strings.TrimSpace(text))
	text = nonWord.ReplaceAllString(text, "")
	text = spaces.ReplaceAllString(text, "-")
	return strings.Trim(text, "-")
}

func Truncate(text string, maxLen int, suffix ...string) string {
	s := "..."
	if len(suffix) > 0 {
		s = suffix[0]
	}
	if len(text) <= maxLen {
		return text
	}
	trunc := text[:maxLen]
	if last := strings.LastIndex(trunc, " "); last > 0 {
		trunc = trunc[:last]
	}
	return trunc + s
}
