## WTF Stockphotos jQuery Plugin
Replace image elements with crazy stock photos

### Example

```javascript
// replace all images
$.wtfstockphotos('img')

// replace an images by class or id
$.wtfstockphotos('.swappable-image')
```

### Options

`limit` (default 30) - limit number of images fetched from reddit. will make initial request faster.

  $.wtfstockphotos('.swappable-image', { limit: 10 })
