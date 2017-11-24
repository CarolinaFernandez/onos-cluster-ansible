#!/usr/bin/python

import re


class FilterModule(object):
    def filters(self):
        return {
            "iface_exists": self.iface_exists,
            "iface_in_target_node": self.iface_in_target_node,
            "ip_compute_subnet": self.ip_compute_subnet,
            "ip_strip_subnet": self.ip_strip_subnet,
        }

    def match_get_nth_group(self, reg_exp, data, nth):
        reg_match = re.match(reg_exp, str(data))
        if reg_match is not None and reg_match.groups >= (nth + 1):
            return reg_match.group(nth)
        return data

    def iface_exists(self, data, hostvars):
        return data in hostvars["ansible_interfaces"]

    def iface_in_target_node(self, dict_nodes, target_ip, iface_ip):
        for node, ips in dict_nodes.iteritems():
            ips = str(ips["ip"])
            if target_ip in ips and iface_ip in ips:
                return True
        return False

    def ip_compute_subnet(self, data):
        reg_exp = "\\b(\d{1,3}.)(\d{1,3}.)(\d{1,3}.)(\d{1,3})\\b"
        return re.sub(reg_exp, "\\1\\2\\3*", data)

    def ip_strip_subnet(self, data):
        reg_exp = "(.*)\\/(?:.*)"
        return self.match_get_nth_group(reg_exp, data, 1)
