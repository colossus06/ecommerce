#!/bin/bash
helm uninstall grafana prometheus -n monitoring
helm uninstall istio-base istiod -n istio-system 
