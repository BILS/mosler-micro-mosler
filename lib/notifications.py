#!/usr/bin/env python
import web
import sys

_notifications = {key: {} for key in sys.argv[2:] }
_progress = {key: '.?.' for key in sys.argv[2:] }
_failures = {key: None for key in sys.argv[2:] }

urls = (
    '/', 'Status',
    '/show_progress', 'Show_Progress',
    '/progress/(?P<machine>.+)', 'Progress',
    '/fail/(?P<machine>.+)', 'Fail',
    '/(?P<machine>.+)/(?P<task>.+)', 'Task'
)

class Status:
    def GET(self):
        output = '======= Notifications =======\n'
        for k, v in _notifications.items():
            d = ' '.join(['[ %s | %s ]' % (key, value) for (key, value) in v.items()])
            output += '{0:>20}: {1}\n'.format(k, d)
        output += '\n======= Failures =======\n'
        output += ' '.join(['{0:>20}: {1}\n'.format(k, v) for (k, v) in _failures.items()])
        output += '\n======= Progress =======\n'
        output += ' '.join(['{0:>20}: {1}\n'.format(k, v) for (k, v) in _progress.items()])
        return output

class Task:
    def GET(self, machine, task):
        d = _notifications.get(machine)
        if d is None:
            sys.stderr.write('[ERROR: %s | %s ] Unknown machine\n' % (machine,task))
            return 'ERR'
        s = d.get(task)
        if s is None:
            sys.stderr.write('[ERROR: %s | %s ] Unknown task\n' % (machine,task))
            return 'ERR'
        else:
            return s

    def POST(self, machine, task):
        d = _notifications.get(machine)
        if d is None:
            sys.stderr.write('[ERROR: %s | %s ] Unknown machine\n' % (machine,task))
            return 'ERR'
        status = web.data()
        d[task] = status
        return '[ %s | %s ] registered for %s' % (task, status, machine)

class Fail:
    def GET(self, machine):
        return _failures.get(machine,'ERR')

    def POST(self, machine):
        if machine not in _failures:
            sys.stderr.write('[ERROR: %s ] Unknown machine\n' % (machine))
            return 'ERR'
        _failures[machine]='FAIL'
        return '[ %s ] failure registered' % machine

class Progress:
    def GET(self, machine):
        return _progress.get(machine,'ERR')

    def POST(self, machine):
        if machine not in _progress:
            sys.stderr.write('[ERROR: %s ] Unknown machine\n' % (machine))
            return 'ERR'
        _progress[machine] = web.data()
        return '[ %s ] progress registered' % machine

class Show_Progress:
    def GET(self):
        return '|' + ' '.join(['{0} {1}|'.format(k, v) for k, v in _progress.items()])

if __name__ == "__main__":
    web.config.debug = False
    app = web.application(urls, globals())
    app.run()
