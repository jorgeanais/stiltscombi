# stiltscombi

Some script in bash used to match and combine astronomical catalogs.

```bash
./crossmatch.sh -f1 <file1> -f2 <file2> -x <output1>
./crossmatch.sh -f1 <file1> -f2 <file3> -x <output2>
./merge -f1 <output1> -f2 <output2> -x <finalcatalog>
```

It takes approximately 40 min in process a catalog of 14 million objects.

## Requirements
It requires the following commands:
- stilts
- pigz
