class Target < ISM::Software
    
    def configure
        super

        configureSource(    arguments:  "   --prefix=/usr \
                                        --enable-mt   \
                                        --with-rmt=/usr/libexec/rmt",
                            path:       buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

end
