---
layout: default
category: Developer
order: 6
---

The parser can be logically divided into 4 stages:
* db: when it grabs articles' metadata directly from the database;
* xml: when it grabs articles' metadata from the xml structure associated to
  each article;
* md: when it parses the content (markdown) of an article, retrieving
  information from it;
* normalization: when it computes inferred values or does simplifications to
  the article built.

Each stage is represented by a function in the file `parser/parser.py`.

### Public methods

The only public method the module exports is `parse(article)`. It receives and
parses an article as it is retrieved from the wiki, and returns a dictionary
with the proper output. It encapsulates the stages mentioned above.

### Private methods

Each private method implements one of the stages defined above. Their rationale
follow.

```
_parse_db(article) => db_article
```

Retrieves (and returns) the relevant information from `article`, directly from
the database structure implied from Django.

```
_parse_xml(xml_content) => xml_article
```

Retrieves and returns relevant xml tags from the article's content. Might do
some manipulations with the tags (such as popping them out of a nested
structure).

```
_parse_md(md_content) => md_article
```

Sets up and calls a LL(\*) parser (ANTLR grammar) that retrieves relevant
information from the markdown itself.

Although not strictly imposed, it seems like a good police to not compute extra
results after the parsing is done, contrary to what is done with the previous
methods. The parser itself should handle the creation of new values.

The grammar used is defined in `Article.g4`.

The parser's generation needs an installation of ANTLR (which although easy is
out of the scope of this document). Afterwards the process of generating it
should be very streamlined. Notice that with the current implementation, there
is no need to generate a parse tree listener not visitor.

_Disclaimer: Currently this function does nothing. It used to, and thus we
decided to leave it be for reference._

```
_normalize(article) => normalized_article
```

This function is used to ensure that the result of a parse is a well defined
structure. Again, it might compute new values from the previous computed ones.
No other stages have the ability to compute values based on others that are not
from their stage only. This restriction is lifted in the normalizer.

#### Wrap up

After the execution of the first three methods, they are joined together and
the result is normalized. The normalized article structure is then returned.
