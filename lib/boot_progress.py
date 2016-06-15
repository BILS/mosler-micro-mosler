#!/usr/bin/env python
import web
import sys

machines = {key: 'booting' for key in sys.argv[2:] }

urls = (
    '/status', 'status',
    '/machine/(?P<name>.+)/(?P<v>.+)', 'update'
)

class status:
    def GET(self):
        output = ''
        for k, v in machines.items():
            output += '{0:>20}: {1}\n'.format(k, v)
        return output

class update:
    def GET(self, name, v):
        if name in machines:
            machines[name] = v
        else:
            return 'Ignoring %s' % name
        # Checking if we should exit
        # Note: That'll make the server say "Oups, empty reply"
        for k, v in machines.items():
            if v != 'ready':
                return 'Still waiting for %s to be ready' % k
        print('Everybody is ready. Exiting the server')
        sys.exit(0)

if __name__ == "__main__":
    web.config.debug = False
    app = web.application(urls, globals())
    app.run()
