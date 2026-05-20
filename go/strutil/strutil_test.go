package strutil

import "testing"

func TestSlugify(t *testing.T) {
	tests := []struct {
		input string
		want  string
	}{
		{"Hello World!", "hello-world"},
		{"Hello @#$ World!!!", "hello-world"},
		{"hello   world", "hello-world"},
		{"-hello world-", "hello-world"},
		{"", ""},
		{"abc", "abc"},
	}

	for _, tt := range tests {
		got := Slugify(tt.input)
		if got != tt.want {
			t.Errorf("Slugify(%q) = %q, want %q", tt.input, got, tt.want)
		}
	}
}

func TestTruncate(t *testing.T) {
	tests := []struct {
		text    string
		maxLen  int
		suffix  string
		want    string
	}{
		{"hello", 10, "...", "hello"},
		{"hello world foo", 8, "...", "hello..."},
		{"hello world foo", 8, "..", "hello.."},
		{"abcdefghij", 5, "...", "abcde..."},
		{"hello world", 5, "...", "hello..."},
	}

	for _, tt := range tests {
		got := Truncate(tt.text, tt.maxLen, tt.suffix)
		if got != tt.want {
			t.Errorf("Truncate(%q, %d, %q) = %q, want %q", tt.text, tt.maxLen, tt.suffix, got, tt.want)
		}
	}
}

func TestTruncateDefaultSuffix(t *testing.T) {
	got := Truncate("hello world foo", 8)
	want := "hello..."
	if got != want {
		t.Errorf("Truncate default suffix = %q, want %q", got, want)
	}
}

func TestReverseWords(t *testing.T) {
	tests := []struct {
		input string
		want  string
	}{
		{"hello world", "world hello"},
		{"a b c d", "d c b a"},
		{"hello", "hello"},
		{"", ""},
	}

	for _, tt := range tests {
		got := ReverseWords(tt.input)
		if got != tt.want {
			t.Errorf("ReverseWords(%q) = %q, want %q", tt.input, got, tt.want)
		}
	}
}
