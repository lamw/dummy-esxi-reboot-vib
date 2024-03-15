# Dummy ESXi Reboot VIB

A "Dummy" ESXi VIB that performs a no-op and requires a system reboot after installation which can be used to test various workflows.

## Requirements
* Ubuntu 22.03 or later
* Docker installed

## Pre-Built VIB/Offline Bundle for ESXi 7.x/8.x

Please see `Releases` tab for download

* **dummy-esxi-reboot.vib** (SHA256: 4e0b7a4b1150e8d0894e2c03996114122296419df7e300f6404e2c554c5748fd)
* **dummy-esxi-reboot-offline-bundle.zip** (SHA256: 5499746a9562eda92b37ec68c78bb39af7fec502fed27f8361b5e6a972e268e9)

## Usage

```console
sudo ./build.sh
```

## Build Example

```
# sudo ./build.sh
Creating Dummy ESXi Reboot VIB build container ...
Untagged: dummyesxirebootvib:latest
Deleted: sha256:3cb75d740a2e05efceceab0abb0ab220b2ade3ba739f1b2243e01aa055283435
Deleted: sha256:90d138944b3106afb8abe8153022e3075d5da86bb4d67d1d62f1cc9865f15925
Deleted: sha256:9e917ff5eab42cb37cb3e2232c511e2cc9ca10e3107dea3f4cacc99562675842
Deleted: sha256:cf5bd4f250a979fb6722a77627fe4baea93b42d289afb187b6cd79cd248e7779
Deleted: sha256:4c84d433f9e09a94e5e34daa463521e44cc7322374152fe8e1f9c03147f4fdf9
DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

Sending build context to Docker daemon  10.24kB
Step 1/6 : FROM lamw/vibauthor:latest
 ---> a673ffe4ba43
Step 2/6 : RUN yum install -y unzip zip
 ---> Running in f5b254ab1dd6
Loaded plugins: fastestmirror, ovl
Setting up Install Process
Determining fastest mirrors
Resolving Dependencies
--> Running transaction check
---> Package unzip.x86_64 0:6.0-5.el6 will be installed
---> Package zip.x86_64 0:3.0-1.el6_7.1 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package         Arch             Version                  Repository      Size
================================================================================
Installing:
 unzip           x86_64           6.0-5.el6                base           152 k
 zip             x86_64           3.0-1.el6_7.1            base           259 k

Transaction Summary
================================================================================
Install       2 Package(s)

Total download size: 411 k
Installed size: 1.1 M
Downloading Packages:
--------------------------------------------------------------------------------
Total                                           2.6 MB/s | 411 kB     00:00
Running rpm_check_debug
Running Transaction Test
Transaction Test Succeeded
Running Transaction
Warning: RPMDB altered outside of yum.
  Installing : zip-3.0-1.el6_7.1.x86_64                                     1/2
  Installing : unzip-6.0-5.el6.x86_64                                       2/2
  Verifying  : unzip-6.0-5.el6.x86_64                                       1/2
  Verifying  : zip-3.0-1.el6_7.1.x86_64                                     2/2

Installed:
  unzip.x86_64 0:6.0-5.el6              zip.x86_64 0:3.0-1.el6_7.1

Complete!
Removing intermediate container f5b254ab1dd6
 ---> 1407327788ba
Step 3/6 : COPY create_dummy_esxi_reboot_vib.sh create_dummy_esxi_reboot_vib.sh
 ---> 04798ec5cbca
Step 4/6 : RUN chmod +x create_dummy_esxi_reboot_vib.sh
 ---> Running in 0a657b6209db
Removing intermediate container 0a657b6209db
 ---> 0bb704920c2a
Step 5/6 : RUN /root/create_dummy_esxi_reboot_vib.sh
 ---> Running in 5e0dbaf158b6
Creating Dummy ESXi Reboot VIB ...
ar: creating dummy-esxi-reboot.vib
Creating compliant offline bundle for Dummy ESXi Reboot VIB ...
Archive:  dummy-esxi-reboot-offline-bundle.zip
  inflating: dummy-esxi-reboot-offline-bundle/metadata.zip
  inflating: dummy-esxi-reboot-offline-bundle/vendor-index.xml
  inflating: dummy-esxi-reboot-offline-bundle/index.xml
  inflating: dummy-esxi-reboot-offline-bundle/vib20/dummy-esxi-reboot/williamlam.com_bootbank_dummy-esxi-reboot_1.0.0-1.0.vib
Archive:  dummy-esxi-reboot-offline-bundle/metadata.zip
  inflating: dummy-esxi-reboot-offline-bundle/metadata/vmware.xml
  inflating: dummy-esxi-reboot-offline-bundle/metadata/vendor-index.xml
  inflating: dummy-esxi-reboot-offline-bundle/metadata/bulletins/dummy-esxi-reboot.xml
  inflating: dummy-esxi-reboot-offline-bundle/metadata/vibs/dummy-esxi-reboot--3462287992180909317.xml
  adding: bulletins/ (stored 0%)
  adding: bulletins/dummy-esxi-reboot.xml (deflated 47%)
  adding: vendor-index.xml (deflated 40%)
  adding: vibs/ (stored 0%)
  adding: vibs/dummy-esxi-reboot--3462287992180909317.xml (deflated 51%)
  adding: vmware.xml (deflated 62%)
  adding: index.xml (deflated 46%)
  adding: metadata.zip (stored 0%)
  adding: vendor-index.xml (deflated 40%)
  adding: vib20/ (stored 0%)
  adding: vib20/dummy-esxi-reboot/ (stored 0%)
  adding: vib20/dummy-esxi-reboot/williamlam.com_bootbank_dummy-esxi-reboot_1.0.0-1.0.vib (deflated 46%)
Removing intermediate container 5e0dbaf158b6
 ---> a7b4a60fe40b
Step 6/6 : CMD ["/bin/bash"]
 ---> Running in a3d1bc77981e
Removing intermediate container a3d1bc77981e
 ---> aefdcb18d40b
Successfully built aefdcb18d40b
Successfully tagged dummyesxirebootvib:latest
```

## Build Output

Both ESXi VIB (`dummy-esxi-reboot.vib`) and Offline Bundle (`dummy-esxi-reboot-offline-bundle.zip`) will be stored in `artifacts/` directory

```console
# tree artifacts/
artifacts/
├── dummy-esxi-reboot-offline-bundle.zip
└── dummy-esxi-reboot.vib

0 directories, 2 files
```

## Install VIB using ESXCLI

```console
# Change ESXi acceptance level to CommunitySupported

[root@esxi:~] esxcli software acceptance set --level CommunitySupported

# Install VIB

[root@esxi:~] esxcli software vib install -v /dummy-esxi-reboot.vib --no-sig-check
Installation Result
   Message: The update completed successfully, but the system needs to be rebooted for the changes to be effective.
   VIBs Installed: williamlam.com_bootbank_dummy-esxi-reboot_1.0.0-1.0
   VIBs Removed:
   VIBs Skipped:
   Reboot Required: true
   DPU Results:
```

## Uninstall VIB using ESXCLI

```console
[root@esxi:~] esxcli software vib remove -n dummy-esxi-reboot
Installation Result
   Message: The update completed successfully, but the system needs to be rebooted for the changes to be effective.
   Components Installed:
   Components Removed: dummy-esxi-reboot
   Components Skipped:
   Reboot Required: true
   DPU Results:
```

## Install Offline Bundle using ESXCLI

```console
# Change ESXi acceptance level to CommunitySupported

[root@esxi:~] esxcli software acceptance set --level CommunitySupported

# Install Offline Bundle

[root@esxi:~] esxcli software component apply -d /dummy-esxi-reboot.vib --no-sig-check
Installation Result
   Message: The update completed successfully, but the system needs to be rebooted for the changes to be effective.
   Components Installed: dummy-esxi-reboot
   Components Removed:
   Components Skipped:
   Reboot Required: true
   DPU Results:
```

## Uninstall Offline Bundle using ESXCLI

```console
[root@esxi:~] esxcli software component remove -n dummy-esxi-reboot
Installation Result
   Message: The update completed successfully, but the system needs to be rebooted for the changes to be effective.
   Components Installed:
   Components Removed: dummy-esxi-reboot
   Components Skipped:
   Reboot Required: true
   DPU Results:
```

## Install Offline Bundle using vSphere Lifecycle Manager (vLCM)

Step 1 - Upload offline bundle to vLCM using vSphere UI by going to `Lifecycle Manager->Actions->Import Updates`

Step 2 - Add component to vSphere Cluster using vSphere UI by going to `vSphere Cluster->Update->Image->Edit` and click on "Add Components" and select `Dummy ESXi Reboot` component and click save

Step 3 - Remediate vSphere Cluster