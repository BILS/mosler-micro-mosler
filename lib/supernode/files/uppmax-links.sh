#!/bin/sh

for path in apps comp libs libs_sl6 parallel uppmax mf; do
    printf "==> Replicating 'nestor->./milou' links in '%s' for 'meles'\n" "/sw/$path"

    find "/sw/$path" \( -name uppmax-local-node-compat -prune \) \
        -o -name "nestor" -lname "*milou" -print |
    while read nestor_link; do
        dir=$( dirname "$nestor_link" )
        if [ ! -e "$dir/meles" ]; then
            printf -- "--> Creating link to 'meles' in '%s'\n" "$dir"
            if ! ln -sf "./milou" "$dir/meles" 2>/dev/null; then
                printf "!!> Was unable to create link\n"
            fi
        fi

        if [ -L "$dir/meles" ] && ! ( cd "$dir/meles" 2>/dev/null ); then
            printf "!!> Can not chdir to '%s' (removing 'meles')'\n" "$dir/meles"
            rm -f "$dir/meles"
        fi
    done

    printf "==> Verifying 'meles->./milou' links in '%s'\n" "/sw/$path"

    find "/sw/$path" \( -name uppmax-local-node-compat -prune \) \
        -o -name "meles" -lname "*milou" -print |
    while read meles_link; do
        dir=$( dirname "$meles_link" )
        if [ ! -e "$dir/milou" ]; then
            printf "!!> Link to non-existant 'milou' in '%s' (removing 'meles')\n" "$dir"
            rm -f "$dir/meles"
        fi
    done

done
