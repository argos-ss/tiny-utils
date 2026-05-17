// Package strutil provides string transformation primitives.
package strutil

import (
	"regexp"
	"strings"
)

var (
	reNonWord = regexp.MustCompile(`[^\w\s-]`)
	reSpaces  = regexp.MustCompile(`[-\s]+`)
)

// Slugify converts text to a lowercase, hyphen-separated slug.
func Slugify(text string) string {
	s := strings.ToLower(strings.TrimSpace(text))
	s = reNonWord.ReplaceAllString(s, "")
	s = reSpaces.ReplaceAllString(s, "-")
	return strings.Trim(s, "-")
}

// Truncate shortens text at a word boundary.
func Truncate(text string, maxLen int, opts ...string) string {
	suffix := "..."
	if len(opts) > 0 {
		suffix = opts[0]
	}

	if len(text) <= maxLen {
		return text
	}

	trunc := text[:maxLen]
	if last := strings.LastIndex(trunc, " "); last > 0 {
		trunc = trunc[:last]
	}
	return trunc + suffix
}

// ReverseWords reverses the word order of a string.
func ReverseWords(text string) string {
	parts := strings.Fields(text)
	for i, j := 0, len(parts)-1; i < j; i, j = i+1, j-1 {
		parts[i], parts[j] = parts[j], parts[i]
	}
	return strings.Join(parts, " ")
}
