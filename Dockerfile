FROM lamw/vibauthor:latest

RUN yum install -y unzip zip

# Copy Dummy VIB build script
COPY create_dummy_esxi_reboot_vib.sh create_dummy_esxi_reboot_vib.sh
RUN chmod +x create_dummy_esxi_reboot_vib.sh

# Run Dummy VIB build script
RUN /root/create_dummy_esxi_reboot_vib.sh

CMD ["/bin/bash"]
